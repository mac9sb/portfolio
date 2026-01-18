import WebUI

struct LogSection: Element {
    let logList: [LogEntry]
    let itemsPerPage: Int = 3

    init(logs: [LogEntry] = logs) {
        self.logList = logs
    }

    private var totalPages: Int {
        max(1, (logList.count + itemsPerPage - 1) / itemsPerPage)
    }

    var body: some Markup {
        LayoutSection(header: SectionHeader(number: "03", label: "LOGS", showTotal: true, totalCount: logList.count)) {
            Stack {
                for (index, log) in logList.enumerated() {
                    LogItem(log: log)
                        .addClass("log-item")
                        .addClass(index < itemsPerPage ? "page-visible" : "hidden")
                }
            }
            .addClass("logs-list")
            .flex(direction: .column)
            .border(of: 1, at: .top, color: .black())
            .frame(minHeight: .custom("200px"))
            .on {
                $0.dark {
                    $0.border(of: 1, at: .top, color: .stone(._700))
                }
            }

            Pagination(currentPage: 1, totalPages: totalPages, sectionId: "logs", itemsPerPage: itemsPerPage)
        }
    }
}
