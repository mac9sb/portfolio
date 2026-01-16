import WebUI

struct Pagination: Element {
    let currentPage: Int
    let totalPages: Int
    let sectionId: String
    let itemsPerPage: Int

    init(currentPage: Int, totalPages: Int, sectionId: String = "", itemsPerPage: Int = 4) {
        self.currentPage = currentPage
        self.totalPages = totalPages
        self.sectionId = sectionId
        self.itemsPerPage = itemsPerPage
    }

    var body: some Markup {
        Stack {
            Stack {
                for page in 1...totalPages {
                    Stack {
                        Text(String(format: "%02d", page))
                            .font(size: .xs2, weight: .bold)
                    }
                    .addClass("pagination-btn")
                    .addClass("pagination-\(sectionId)-\(page)")
                    .frame(width: .spacing(7), height: .spacing(7))
                    .border(of: 1, color: .black())
                    .flex(justify: .center, align: .center)
                    .background(color: page == currentPage ? .black() : .stone(._100))
                    .font(color: page == currentPage ? .stone(._100) : .black())
                    .transition(of: .all, for: 200)
                    .cursor(.pointer)
                    .on {
                        $0.hover {
                            $0.background(color: page == currentPage ? .black() : .custom("#e5e5e0"))
                        }
                    }
                }
            }
            .addClass("pagination-buttons-\(sectionId)")
            .flex(direction: .row)

            // Separator line
            Stack {}
                .flex(grow: .one)
                .frame(height: .px)
                .background(color: .stone(._300))
                .margins(of: 4, at: .horizontal)

            // Page counter
            Text("PAGE \(String(format: "%02d", currentPage)) / \(String(format: "%02d", totalPages))")
                .addClass("pagination-counter-\(sectionId)")
                .font(size: .xs2, tracking: .wider)
                .opacity(60)
        }
        .flex(direction: .row, align: .center)
        .frame(width: .full)
        .margins(of: 4, at: .top)
    }
}
