import WebUI

struct AddIcon: Element {
    let size: Int

    init(size: Int = 4) {
        self.size = size
    }

    var body: some Markup {
        Image(
            source:
                "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 -960 960 960' fill='currentColor'%3E%3Cpath d='M440-440H200v-80h240v-240h80v240h240v80H520v240h-80v-240Z'/%3E%3C/svg%3E",
            description: "Add icon",
            type: .svg
        )
        .frame(width: .spacing(size), height: .spacing(size))
    }
}
