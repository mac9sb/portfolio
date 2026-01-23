# Portfolio

A static portfolio website built with WebUI and Typst, showcasing projects and blog posts.

## Overview

This portfolio site is generated as a static website using:

- **WebUI**: Type-safe HTML generation in Swift
- **WebUITypst**: Typst content rendering for articles
- **Static Site Generation**: Pre-rendered at build time for maximum performance

## Getting Started

### Prerequisites

- Swift 6.2 or later
- Typst (for content rendering)

### Building the Site

1. Clone the repository:

```sh
git clone https://github.com/mac9sb/portfolio.git
cd portfolio
```

2. Build the project:

```sh
swift build -c release
```

3. Generate the static site:

```sh
swift run Portfolio
```

The site will be generated in the `.output` directory.

### Running Locally

To preview the site locally, you can use any static file server:

```sh
# Using Python
cd .output
python3 -m http.server 8000

# Using Node.js (if you have npx)
npx serve .output
```

Then visit `http://localhost:8000` in your browser.

## Architecture

The portfolio is structured as follows:

- **Application.swift**: Main website definition with routes and metadata
- **Pages/**: Page components (Home, Article)
- **Components/**: Reusable UI components
- **Content/**: Typst source files for blog posts
- **Models/**: Data models for projects and log entries

### Content Management

Blog posts are written in Typst format and stored in `Sources/Portfolio/Content/`. The application:

1. Reads Typst files from the Content directory
2. Renders them to HTML using WebUITypst
3. Generates article pages with proper metadata

### Adding New Content

1. Create a new `.typ` file in `Sources/Portfolio/Content/`
2. Add a corresponding entry to the `logs` array in `Models/LogEntry.swift`
3. Rebuild the site

## Development

To contribute to the portfolio:

1. Clone the repository
2. Make your changes
3. Build and test: `swift build && swift test`
4. Generate the site to verify: `swift run Portfolio`

## License

See LICENSE file for details.
