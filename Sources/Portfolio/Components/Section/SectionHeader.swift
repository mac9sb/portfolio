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
                .font(size: .xs2, weight: .light, tracking: .widest, color: .teal(._800))
                .on {
                    $0.dark {
                        $0.font(color: .teal(._400))
                    }
                }

            if showTotal, let count = totalCount {
                Text("total: \(count)")
                    .font(size: .xs2, weight: .bold, casing: .uppercase)
                    .opacity(40)
            }
        }
        .flex(direction: .row, justify: .between, align: .center)
        .margins(of: 6, at: .bottom)
    }
}
