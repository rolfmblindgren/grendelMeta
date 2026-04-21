# grendelMeta

`grendelMeta` er en liten hjelpepake for Shiny-apper som trenger bedre metadata for deling i sosiale medier og søk.

Pakken bygger én `shiny::tags$head()`-blokk med:

- canonical URL
- `description`
- Open Graph-tagger
- Twitter Card-tagger
- valgfri schema.org JSON-LD
- valgfri Bing-verifisering

Den kan lese metadata fra en YAML-fil eller ta imot en navngitt liste direkte i R.

If you only need the short contract: there is one exported function, `social_meta()`. It returns a `shiny::tags$head()` fragment that you place in the UI of a Shiny app.

## Hva den gjør

Når du kaller `social_meta()`, gjør pakken dette:

1. Leser inn metadata fra YAML eller bruker lista du sender inn.
2. Fyller inn standardverdier for vanlige felt som språk, robots og Twitter-kort.
3. Sjekker at de fire grunnfeltene finnes:
   - `title`
   - `description`
   - `url`
   - `image`
4. Bygger HTML-tagger som du legger i Shiny-UI-en.
5. Legger til JSON-LD hvis schema ikke er slått av.

## API i kortform

`social_meta(meta)`:

- `meta` kan være en YAML-sti eller en navngitt liste
- de fire grunnfeltene `title`, `description`, `url` og `image` må finnes
- hvis `meta` er en tekststreng, leses den som filsti med `yaml::read_yaml()`
- hvis `meta` mangler en nøkkel, brukes standardverdi der pakken har en, ellers stoppes det med feil
- hvis `schema` er noe annet enn `FALSE`, blir JSON-LD laget
- hvis `schema = FALSE`, blir JSON-LD ikke skrevet ut

## Kort bruk

```r
library(shiny)
library(grendelMeta)

ui <- fluidPage(
  social_meta("meta.yml"),
  h1("Min app")
)

server <- function(input, output, session) {}

shinyApp(ui, server)
```

Du kan også sende inn en liste:

```r
social_meta(list(
  title = "Helsekalkulator",
  description = "En enkel kalkulator for pasienter og ansatte.",
  url = "https://example.no/helse",
  image = "https://example.no/preview.png"
))
```

## Eksempel på `meta.yml`

```yaml
title: "Helsekalkulator"
description: "En enkel kalkulator for pasienter og ansatte."
url: "https://example.no/helse"
image: "https://example.no/preview.png"

site_name: "Grendel"
locale: "nb_NO"
twitter_card: "summary_large_image"
twitter_site: "@grendelno"
twitter_creator: "@rolf"

image_alt: "Skjermbilde av helsekalkulatoren"
twitter_image_alt: "Skjermbilde av helsekalkulatoren"

schema: true
author_name: "Rolf Lindgren"
publisher_name: "Grendel"
bing_site_verification: "DIN_BING_NØKKEL"
```

## Felter

### Påkrevde felter

| Felt | Hva det brukes til |
| --- | --- |
| `title` | Sidetittel og delingstittel |
| `description` | Beskrivelse for søk og sosiale medier |
| `url` | Canonical URL, `og:url` og `twitter:url` |
| `image` | Forsidebilde for deling |

### Vanlige valgfrie felter

| Felt | Standard | Kommentar |
| --- | --- | --- |
| `locale` | `nb_NO` | Språk/locale for Open Graph og JSON-LD |
| `site_name` | `Grendel` | Navn på nettstedet |
| `robots` | `index,follow,max-image-preview:large,max-snippet:-1,max-video-preview:-1` | Robots-direktiv |
| `twitter_card` | `summary_large_image` | Twitter-korttype |
| `schema` | på | Sett til `FALSE` for å slå av JSON-LD |
| `schema_type` | `WebApplication` | Schema.org-type |
| `application_category` | `MedicalWebApplication` | Schema.org-kategori |
| `operating_system` | `Any` | Schema.org-operativsystem |
| `author_name` | tom | Schema.org-forfatter |
| `publisher_name` | tom | Schema.org-utgiver |
| `in_language` | samme som `locale` | Språk i schema.org |

### Bilde- og delingsfelt

| Felt | Bruk |
| --- | --- |
| `image_width` | `og:image:width` |
| `image_height` | `og:image:height` |
| `image_type` | `og:image:type` |
| `image_alt` | `og:image:alt` |
| `twitter_image_alt` | `twitter:image:alt` |
| `twitter_site` | `twitter:site` |
| `twitter_creator` | `twitter:creator` |
| `bing_site_verification` | `msvalidate.01` |

### Schema-felt

Når `schema` ikke er satt til `FALSE`, blir dette med i JSON-LD hvis verdiene finnes:

- `educational_use`
- `is_accessible_for_free`
- `disclaimer`

## Viktige detaljer

- `social_meta()` returnerer en HTML-blokk. Den skal legges inn i UI-en, ikke i serveren.
- Hvis du sender inn en tekststreng, tolkes den som filsti til YAML.
- Hvis filen ikke finnes, får du en feilmelding med filstien.
- Hvis et av grunnfeltene mangler, stopper funksjonen med en tydelig feil.
- Feltet `schema` er avskrudd bare når det er satt til `FALSE`. Alle andre verdier lar schema-delen stå på.
- Standardverdiene er laget for en norsk Shiny-app, men alt kan overstyres.

## Referanse

Se [`docs/API.md`](docs/API.md) for en full feltkontrakt og [`docs/REFERENCE.md`](docs/REFERENCE.md) for praktiske bruksmønstre.
