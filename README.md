# shinyMeta

`shinyMeta` is a small helper package for Shiny apps that need social and search metadata.

It builds one `shiny::tags$head()` fragment containing:

- canonical URL
- `description`
- Open Graph tags
- Twitter Card tags
- optional schema.org JSON-LD
- optional Bing site verification

The package accepts either a YAML file path or a named list.

If you only need the short contract: there is one exported function, `social_meta()`. It returns a `shiny::tags$head()` fragment that belongs in the UI of a Shiny app.

## What it does

When you call `social_meta()`, the package:

1. Reads metadata from YAML or uses the list you pass in.
2. Fills in safe defaults for common fields like locale, robots, and Twitter card type.
3. Checks that the required fields exist.
4. Builds HTML tags for Shiny UI.
5. Adds JSON-LD unless you turn schema off.

## API in short

`social_meta(meta)`:

- `meta` may be a YAML path or a named list
- `title`, `description`, `url`, and `image` are required
- if `meta` is a character string, it is read with `yaml::read_yaml()`
- missing keys use package defaults where provided
- `schema = FALSE` disables JSON-LD output
- any other value of `schema` keeps JSON-LD enabled

## Quick use

```r
library(shiny)
library(shinyMeta)

ui <- fluidPage(
  social_meta("meta.yml"),
  h1("My app")
)

server <- function(input, output, session) {}

shinyApp(ui, server)
```

You can also pass a list directly:

```r
social_meta(list(
  title = "Example app",
  description = "A short app description.",
  url = "https://example.no",
  image = "https://example.no/share.png"
))
```

## Example `meta.yml`

```yaml
title: "Example app"
description: "A short app description."
url: "https://example.no"
image: "https://example.no/share.png"

locale: "en_US"
twitter_card: "summary_large_image"
twitter_site: "@example"
twitter_creator: "@example"

image_alt: "Screenshot of the app"
twitter_image_alt: "Screenshot of the app"

schema: true
author_name: "Rolf Lindgren"
publisher_name: "Example AS"
bing_site_verification: "YOUR_BING_CODE"
```

## Fields

### Required fields

| Field | Used for |
| --- | --- |
| `title` | Page title and share title |
| `description` | Search and share description |
| `url` | Canonical URL, `og:url`, and `twitter:url` |
| `image` | Share image |

### Common optional fields

| Field | Default | Notes |
| --- | --- | --- |
| `locale` | `en_US` | Open Graph locale and schema language default |
| `robots` | `index,follow,max-image-preview:large,max-snippet:-1,max-video-preview:-1` | Robots directive |
| `twitter_card` | `summary_large_image` | Twitter card type |
| `schema` | on | Set to `FALSE` to suppress JSON-LD |
| `schema_type` | `WebApplication` | Schema.org type |
| `operating_system` | `Any` | Schema.org operating system |
| `author_type` | `Person` | Schema.org author type |
| `publisher_type` | `Organization` | Schema.org publisher type |
| `in_language` | same as `locale` | Schema.org language |

### Optional share fields

| Field | Used for |
| --- | --- |
| `site_name` | `og:site_name` |
| `image_width` | `og:image:width` |
| `image_height` | `og:image:height` |
| `image_type` | `og:image:type` |
| `image_alt` | `og:image:alt` |
| `twitter_site` | `twitter:site` |
| `twitter_creator` | `twitter:creator` |
| `twitter_image_alt` | `twitter:image:alt` |
| `bing_site_verification` | `msvalidate.01` |
| `application_category` | `applicationCategory` in schema.org |
| `educational_use` | `educationalUse` in schema.org |
| `is_accessible_for_free` | `isAccessibleForFree` in schema.org |
| `disclaimer` | `disclaimer` in schema.org |

## Notes

- `social_meta()` returns HTML tags, so put it in the UI, not in the server.
- If you pass a character string, it is treated as a file path.
- If the file does not exist, the function stops with a clear error.
- If a required field is missing, the function stops with a clear error.
- The package is intentionally small and opinionated, but every default can be overridden.

## Reference

See [`docs/API.md`](docs/API.md) for a full field contract and [`docs/REFERENCE.md`](docs/REFERENCE.md) for practical usage patterns.
