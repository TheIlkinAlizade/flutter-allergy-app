# AllergyCheck

![CI](https://github.com/TheIlkinAlizade/flutter-allergy-app/actions/workflows/ci.yml/badge.svg)

Food allergen risk checker. Photograph a food label, and the app reads the ingredients, matches them against your allergy profile, and shows a risk score with the reasons behind it.

> **Medical disclaimer.** This app helps you read food labels but is not a substitute for professional medical advice. Text recognition can miss or misread ingredients. Always check the packaging and follow your doctor's guidance.

## Features

- Label scanning from the camera or the photo library
- Allergy profile with 14 allergen categories and three severity levels (mild, moderate, anaphylaxis)
- Transparent risk score with a per-allergen breakdown
- Handling of "may contain" and trace warnings
- Searchable scan history, stored on the device
- English, Azerbaijani, Turkish and Russian interface and label matching
- Android app and web app from one Flutter codebase

## How it works

1. The app downscales the photo and sends it to a small Cloudflare Worker.
2. The Worker holds the Gemini API key, asks Gemini to transcribe the ingredient list and any "may contain" statements as JSON, validates the result, and returns it.
3. The app matches the ingredients against a local multilingual allergen dictionary.
4. A deterministic calculator scores the matches against the user's profile.

The AI only reads text. It never decides what counts as an allergen or how risky a product is, so results are testable and explainable.

## Risk model

```
R = Σ (Sᵢ × Cᵢ) × (1 + C_cross)
```

| Symbol | Meaning | Values |
|---|---|---|
| S | Severity chosen by the user | mild 1, moderate 2, anaphylaxis 3 |
| C | Match confidence | listed ingredient 1.0, derived ingredient or E-number 0.7 |
| C_cross | "May contain" factor, when enabled in the profile | 0.5 |

Allergens that appear only in a "may contain" warning count at half weight when the option is on, and are shown as warnings without scoring when it is off. A score of 3.0 or more, or any scored match for an allergen set to anaphylaxis, is rated high risk. The thresholds live in `lib/core/risk_constants.dart`.

## Project structure

```
lib/
  config/      app configuration and theme
  core/        risk calculator, allergen matcher, text normalizer (pure Dart)
  data/        models, services, storage
  features/    scan, result, history, profile, settings, shell
  l10n/        translations (ARB) and generated localization code
assets/data/   allergen dictionary
proxy/         Cloudflare Worker that calls Gemini
test/          unit tests
```

## Setup

Requirements: Flutter 3.41 or newer (Dart 3.11), Node.js LTS, a Google Gemini API key, and a free Cloudflare account. Building the Android app also needs the Android SDK.

### Proxy

```
cd proxy
npm install
npx wrangler login
npx wrangler deploy
npx wrangler secret put GEMINI_API_KEY
npx wrangler secret put ALLOWED_ORIGINS
```

The deploy prints the Worker URL. `ALLOWED_ORIGINS` takes a comma-separated list of website origins with no spaces and no trailing slashes, for example `http://localhost:5050`. Only browser builds need it, because native Android requests carry no origin.

| Name | Kind | Purpose |
|---|---|---|
| `GEMINI_API_KEY` | secret | Gemini API key |
| `ALLOWED_ORIGINS` | secret | Website origins allowed to call the proxy from a browser |
| `GEMINI_MODEL` | variable in `wrangler.toml` | Model used to read labels. Update it when Google retires a model |
| `GEMINI_FALLBACK_MODEL` | variable, optional | Model used when the primary one is overloaded |
| `GEMINI_THINKING_LEVEL` | variable | Thinking level sent to Gemini. Leave empty to omit it |

For local Worker development, copy `proxy/.dev.vars.example` to `proxy/.dev.vars` and fill in the values.

### App

1. Copy `env/dev.example.json` to `env/dev.json`.
2. Set `API_BASE_URL` to your Worker URL.
3. Run `flutter pub get`.
4. Run `flutter run --dart-define-from-file=env/dev.json`.

For the web build during development, run `flutter run -d chrome --web-port=5050 --dart-define-from-file=env/dev.json` and make sure `http://localhost:5050` is in the `ALLOWED_ORIGINS` secret.

## Build

```
flutter build apk --release --dart-define-from-file=env/dev.json
flutter build web --release --dart-define-from-file=env/dev.json
```

Android release signing reads `android/key.properties`, which is not committed:

```
storePassword=your-password
keyPassword=your-password
keyAlias=release
storeFile=/path/to/release.jks
```

Without that file the release build falls back to the debug key, which is only suitable for testing.

## Tests

```
flutter analyze
flutter test
```

## Security notes

- The Gemini key exists only as a Cloudflare secret. It is never in the app or the repository.
- The proxy URL is compiled into the app and can be extracted from it. The proxy therefore limits request rate per IP, limits image size, and accepts only JPEG, PNG and WebP. Use a Gemini key without billing attached, so abuse can exhaust the free quota but cannot create charges.
- The origin check stops other websites from using the proxy through a browser. It does not authenticate native apps.
- The Android signing key, its passwords, and the environment files are ignored by Git, and commits are scanned for secrets.

## Privacy and limitations

- Scan history and the allergy profile are stored only on the device.
- Label photos are sent to the Worker and on to the Gemini API. The Worker does not store them. Review Google's terms for how Gemini API content is handled, especially on the free tier.
- The allergen dictionary is a starting point and has not been medically validated.
- Translations should be reviewed by native speakers before wider use.
- Gemini models are retired from time to time, so `GEMINI_MODEL` needs occasional maintenance.