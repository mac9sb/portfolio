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
                // Left arrow
                Stack {
                    Stack {
                        MarkupString(
                            content: """
                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" style="width: 100%; height: 100%;">
                                    <path d="M15.41 7.41L14 6l-6 6 6 6 1.41-1.41L10.83 12z"/>
                                </svg>
                                """)
                    }
                    .frame(width: .spacing(4), height: .spacing(4))
                }
                .addClass("pagination-left-\(sectionId)")
                .addClass(currentPage > 1 ? "page-active" : "page-disabled")
                .frame(width: .spacing(7), height: .spacing(7))
                .border(of: 1, color: .stone(._300))
                .flex(justify: .center, align: .center)
                .background(color: .stone(._100))
                .font(color: currentPage > 1 ? .black() : .stone(._400))
                .transition(of: .all, for: 200)
                .cursor(currentPage > 1 ? .pointer : .notAllowed)
                .on {
                    $0.hover {
                        $0.background(color: .stone(._200))
                    }
                    $0.dark {
                        $0.background(color: .stone(._800))
                        $0.border(of: 1, color: .stone(._700))
                        $0.font(color: currentPage > 1 ? .stone(._100) : .stone(._500))
                    }
                }

                // Right arrow
                Stack {
                    Stack {
                        MarkupString(
                            content: """
                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" style="width: 100%; height: 100%;">
                                    <path d="M10 6L8.59 7.41 13.17 12l-4.58 4.59L10 18l6-6z"/>
                                </svg>
                                """)
                    }
                    .frame(width: .spacing(4), height: .spacing(4))
                }
                .addClass("pagination-right-\(sectionId)")
                .addClass(currentPage < totalPages ? "page-active" : "page-disabled")
                .frame(width: .spacing(7), height: .spacing(7))
                .border(of: 1, color: .stone(._300))
                .flex(justify: .center, align: .center)
                .background(color: .stone(._100))
                .font(color: currentPage < totalPages ? .black() : .stone(._400))
                .transition(of: .all, for: 200)
                .cursor(currentPage < totalPages ? .pointer : .notAllowed)
                .on {
                    $0.hover {
                        $0.background(color: .stone(._200))
                    }
                    $0.dark {
                        $0.background(color: .stone(._800))
                        $0.border(of: 1, color: .stone(._700))
                        $0.font(color: currentPage < totalPages ? .stone(._100) : .stone(._500))
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
                .on {
                    $0.dark {
                        $0.background(color: .stone(._700))
                    }
                }

            // Page counter
            Text("page \(String(format: "%02d", currentPage)) / \(String(format: "%02d", totalPages))")
                .addClass("pagination-counter-\(sectionId)")
                .font(size: .xs2, tracking: .wider, casing: .uppercase)
                .opacity(60)
        }
        .flex(direction: .row, align: .center)
        .frame(width: .full)
        .margins(of: 4, at: .top)
    }
}
