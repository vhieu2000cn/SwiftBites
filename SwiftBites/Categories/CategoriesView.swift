import SwiftUI
import SwiftData

struct CategoriesView: View {
    @State private var query = ""
    @Query private var categories: [Category]
    @Environment(\.modelContext) private var context
    private var fillterdCategories: [Category] {
        let description = FetchDescriptor<Category>(predicate: #Predicate<Category>{
            if query.isEmpty {
                return true
            } else {
                return $0.name.localizedStandardContains(query)
            }
        })
        do {
            return try context.fetch(description)
        }catch{
            return []
        }
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            content
                .modifier(CustomToolBar())
        }
    }
    
    // MARK: - Views
    
    @ViewBuilder
    private var content: some View {
        if categories.isEmpty {
            empty
        } else {
            list(for: fillterdCategories)
        }
    }
    
    private var empty: some View {
        ContentUnavailableView(
            label: {
                Label("No Categories", systemImage: "list.clipboard")
            },
            description: {
                Text("Categories you add will appear here.")
            },
            actions: {
                NavigationLink("Add Category", value: CategoryForm.Mode.add)
                    .buttonBorderShape(.roundedRectangle)
                    .buttonStyle(.borderedProminent)
            }
        )
    }
    
    private var noResults: some View {
        ContentUnavailableView(
            label: {
                Text("Couldn't find \"\(query)\"")
            }
        )
    }
    
    private func list(for categories: [Category]) -> some View {
        ScrollView(.vertical) {
            if categories.isEmpty {
                noResults
            } else {
                LazyVStack(spacing: 10) {
                    ForEach(categories, content: CategorySection.init)
                }
            }
        }
        .searchable(text: $query)
    }
}

// MARK: Custom general view for title

struct CustomToolBar: ViewModifier {
    @Query private var categories: [Category]
    
    func body(content: Content) -> some View {
        content
            .navigationTitle("Categories")
            .toolbar {
                if !categories.isEmpty {
                    NavigationLink(value: CategoryForm.Mode.add) {
                        Label("Add", systemImage: "plus")
                    }
                }
            }
            .navigationDestination(for: CategoryForm.Mode.self) { mode in
                CategoryForm(mode: mode)
            }
            .navigationDestination(for: RecipeForm.Mode.self) { mode in
                RecipeForm(mode: mode)
            }
    }
}
