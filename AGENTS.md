# AGENTS.md

This file provides guidance to Qoder (qoder.com) when working with code in this repository.

## Project Overview

This is a HarmonyOS Next application built with ArkTS/ETS (Extended TypeScript) language. The app appears to be an educational tool with modules for mathematics, chemistry, and English learning.

## Code Architecture and Structure

### High-Level Architecture
- **entry**: Main module containing all application code
  - **src/main**: Production source code
    - **ets**: Entry point and UI components
      - **entryability**: Main application entry point (`EntryAbility.ets`)
      - **pages**: UI pages organized by subject (math, chemistry, english)
    - **resources**: Application resources (images, strings, colors)
  - **src/ohosTest**: Unit tests using Hypium framework
  - **src/test**: Additional test files

### Key Components
1. **Entry Point**: `entry/src/main/ets/entryability/EntryAbility.ets` - Launches the splash screen
2. **Navigation**: Managed through `main_pages.json` which defines the page routing
3. **UI Pages**: Organized by subject matter in `entry/src/main/ets/pages/`

## Development Commands

### Building the Project
```bash
# Build the project (development mode)
hvigor build

# Build for release
hvigor build --mode release

# Clean build artifacts
hvigor clean
```

### Running Tests
```bash
# Run unit tests
hvigor test

# Run specific test files
hvigor test --testsuite <test-suite-name>
```

### Development Workflow
1. **Project Structure**: Pages are organized by subject areas (math, chemistry, English)
2. **Adding New Pages**: 
   - Create ETS files in the appropriate subject folder under `entry/src/main/ets/pages/`
   - Add page routes to `entry/src/main/resources/base/profile/main_pages.json`
3. **Resource Management**: 
   - Images: `entry/src/main/resources/base/media/`
   - Strings: `entry/src/main/resources/base/element/string.json`
   - Colors: `entry/src/main/resources/base/element/color.json`

### Testing Framework
- Uses Hypium testing framework (`@ohos/hypium`)
- Test files located in `entry/src/ohosTest/ets/test/`
- Test structure follows describe/beforeAll/beforeEach/it/expect pattern

## Key Dependencies
- `@ohos/hypium`: Testing framework
- `@ohos/hamock`: Mocking library for tests