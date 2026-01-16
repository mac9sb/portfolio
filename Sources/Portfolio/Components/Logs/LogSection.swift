import WebUI

struct LogSection: Element {
    let logList: [LogEntry]

    init(logs: [LogEntry] = logs) {
        self.logList = logs
    }

    var body: some Markup {
        LayoutSection(header: SectionHeader(number: "03", label: "LOGS", showTotal: true, totalCount: logList.count)) {
            Stack {
                for log in logList {
                    LogItem(log: log)
                }
            }
            .flex(direction: .column)
            .border(of: 1, at: .top, color: .black())

            Pagination(currentPage: 1, totalPages: 1)
        }
    }
}
