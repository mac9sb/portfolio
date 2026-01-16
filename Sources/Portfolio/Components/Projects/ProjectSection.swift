import WebUI

struct ProjectSection: Element {
    let projectList: [Project]
    let itemsPerPage: Int = 4

    init(projects: [Project] = projects) {
        self.projectList = projects
    }

    private var totalPages: Int {
        max(1, (projectList.count + itemsPerPage - 1) / itemsPerPage)
    }

    var body: some Markup {
        LayoutSection(header: SectionHeader(number: "02", label: "PROJECTS")) {
            Stack {
                for (index, project) in projectList.enumerated() {
                    ProjectCard(project: project)
                        .addClass("project-item")
                        .addClass(index < itemsPerPage ? "page-visible" : "hidden")
                }
            }
            .addClass("projects-grid")
            .addClass("content-start")
            .grid(columns: 1, gap: 4)
            .frame(minHeight: .custom("460px"))
            .on {
                $0.md {
                    $0.grid(columns: 2, gap: 4)
                    $0.frame(minHeight: .custom("456px"))
                }
            }

            Pagination(currentPage: 1, totalPages: totalPages, sectionId: "projects", itemsPerPage: itemsPerPage)
        }
    }
}
