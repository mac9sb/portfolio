import WebUI

struct SectionHeader: Element {
    let number: String
    let label: String
    let showTotal: Bool
    let totalCount: Int?

    init(number: String, label: String, showTotal: Bool = false, totalCount: Int? = nil) {
        self.number = number
        self.label = label
        self.showTotal = showTotal
        self.totalCount = totalCount
    }

    var body: some Markup {
        Stack {
            Heading(.headline, "\(number) // \(label)")
                .font(size: .xs, weight: .bold, tracking: .widest, color: .custom("#2d514e"))

            if showTotal, let count = totalCount {
                Text("TOTAL: \(count)")
                    .font(size: .xs, weight: .bold)
                    .opacity(40)
            }
        }
        .flex(direction: .row, justify: .between, align: .center)
        .margins(of: 6, at: .bottom)
    }
}
