import WebUI

struct CodeIcon: Element {
    let size: Int

    init(size: Int = 5) {
        self.size = size
    }

    var body: some Markup {
        Image(
            source:
                "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 -960 960 960' fill='currentColor'%3E%3Cpath d='M320-240 80-480l240-240 57 57-184 184 183 183-56 56Zm320 0-57-57 184-184-183-183 56-56 240 240-240 240Z'/%3E%3C/svg%3E",
            description: "Code icon",
            type: .svg
        )
        .frame(width: .spacing(size), height: .spacing(size))
    }
}
