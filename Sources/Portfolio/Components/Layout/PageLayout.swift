import WebUI

struct PageLayout: Element {
    let content: MarkupContentBuilder

    init(@MarkupBuilder content: @escaping MarkupContentBuilder) {
        self.content = content
    }

    var body: some Markup {
        Stack {
            Stack {
                SiteHeader()

                Main {
                    content().map { $0.render() }.joined()
                }
                .flex(direction: .column, grow: .one)

                SiteFooter()
            }
            .position(.relative)
            .zIndex(10)
            .border(of: 1, at: .horizontal, color: .black())
            .frame(width: .full, minHeight: .viewport(.dynamicViewHeight))
            .flex(direction: .column)
            .background(color: .custom("#f5f5f3"))
            .shadow(size: .xl2)
            .frame(width: .full, maxWidth: .custom("1200px"))
        }
        .position(.relative)
        .frame(width: .full, minHeight: .viewport(.dynamicViewHeight))
        .flex(direction: .column, align: .center)
        .background(color: .custom("#f5f5f3"))
    }
}
