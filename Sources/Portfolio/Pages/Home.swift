import WebUI

struct Home: Document {
    var metadata: Metadata {
        Metadata(from: PortfolioSite.baseMetadata)
    }

    var path: String? { "index" }

    var body: some Markup {
        PageLayout {
            Hero()
            ProjectSection()
            LogSection()
        }
    }
}
