# shinyseo

[![CRAN version](https://www.r-pkg.org/badges/version/shinyseo)](https://CRAN.R-project.org/package=shinyseo)
[![CRAN total downloads](https://cranlogs.r-pkg.org/badges/grand-total/shinyseo?color=blue)](https://CRAN.R-project.org/package=shinyseo)

`shinyseo` is a small helper package for Shiny apps that need social and search metadata.

It builds one `shiny::tags$head()` fragment containing:

- canonical URL
- `description`
- Open Graph tags for Facebook, LinkedIn, Slack, and similar previews
- Twitter Card tags
- optional schema.org JSON-LD
- optional Bing, Google, Yandex, Baidu, Naver, Facebook, and Pinterest verification

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

## Config cheat sheet

Minimal configuration:

```yaml
title: "Example app"
description: "A short app description."
url: "https://example.no"
image: "https://example.no/share.png"
```

Common extras:

| Field | What it does |
| --- | --- |
| `locale` | Sets Open Graph locale and schema language default |
| `robots` | Controls the robots meta tag |
| `twitter_card` | Sets the Twitter card type |
| `site_name` | Sets `og:site_name` |
| `twitter_site` | Sets `twitter:site` |
| `twitter_creator` | Sets `twitter:creator` |
| `image_alt` | Sets `og:image:alt` |
| `twitter_image_alt` | Sets `twitter:image:alt` |
| `bing_site_verification` | Sets Bing verification |
| `google_site_verification` | Sets Google Search Console verification |
| `yandex_site_verification` | Sets Yandex Webmaster verification |
| `baidu_site_verification` | Sets Baidu Webmaster verification |
| `naver_site_verification` | Sets Naver Webmaster verification |
| `facebook_domain_verification` | Sets Facebook domain verification |
| `pinterest_domain_verification` | Sets Pinterest domain verification |
| `schema` | Set to `FALSE` to disable JSON-LD |

If you want shared defaults across several apps, you can set these in
`.Renviron` and let app-level YAML override them when needed:

- `SHINYSEO_TWITTER_SITE`
- `SHINYSEO_TWITTER_CREATOR`

## Quick use

```r
library(shiny)
library(shinyseo)

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

## Vignettes

The long-form package docs live in vignettes:

- [API contract](vignettes/API.Rmd)
- [Reference guide](vignettes/REFERENCE.Rmd)

If the package is installed, you can also open them with `browseVignettes("shinyseo")`.
