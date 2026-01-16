import WebUI

struct ProjectSection: Element {
    let projectList: [Project]

    init(projects: [Project] = projects) {
        self.projectList = projects
    }

    var body: some Markup {
        LayoutSection(header: SectionHeader(number: "02", label: "PROJECTS")) {
            Stack {
                for project in projectList {
                    ProjectCard(project: project)
                }
            }
            .grid(columns: 1, gap: 4)
            .on {
                $0.md {
                    $0.grid(columns: 2, gap: 4)
                }
            }

            Pagination(currentPage: 1, totalPages: projects.count / 4)
        }
    }
}
