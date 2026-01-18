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
        .padding(of: 6)
        .background(color: .stone(._100))
        .border(of: 1, at: .bottom, color: .black())
        .on {
            $0.dark {
                $0.background(color: .stone(._900))
                $0.border(of: 1, at: .bottom, color: .stone(._700))
                $0.font(color: .stone(._100))
            }
        }
    }
}
