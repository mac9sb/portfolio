import WebUI

struct LayoutSection: Element {
    let header: SectionHeader
    let content: MarkupContentBuilder

    init(header: SectionHeader, @MarkupBuilder content: @escaping MarkupContentBuilder) {
        self.header = header
        self.content = content
    }

    var body: some Markup {
        Section {
            header
            content().map { $0.render() }.joined()
        }
        .padding(of: 8)
        .background(color: .custom("#f5f5f3"))
        .border(of: 1, at: .bottom, color: .black())
        .font(family: "Space Grotesk")
    }
}
