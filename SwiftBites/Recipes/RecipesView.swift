import SwiftUI
import SwiftData

struct RecipesView: View {
    @State private var query : String = ""
    @Query private var recipes: [Recipe]
    @State private var sortOrder = SortDescriptor(\ Recipe.name)
    @Environment(\.modelContext) private var context
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Recipes")
                .toolbar {
                    if !recipes.isEmpty {
                        sortOptions
                        ToolbarItem(placement: .topBarTrailing) {
                            NavigationLink(value: RecipeForm.Mode.add) {
                                Label("Add", systemImage: "plus")
                            }
                        }
                    }
                }
                .navigationDestination(for: RecipeForm.Mode.self) { mode in
                    RecipeForm(mode: mode)
                }
        }
    }
    
    // MARK: - Views
    
    @ToolbarContentBuilder
    var sortOptions: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Menu("Sort", systemImage: "arrow.up.arrow.down") {
                Picker("Sort", selection: $sortOrder) {
                    Text("Name")
                        .tag(SortDescriptor(\ Recipe.name))
                    
                    Text("Serving (low to high)")
                        .tag(SortDescriptor(\ Recipe.serving, order: .forward))
                    
                    Text("Serving (high to low)")
                        .tag(SortDescriptor(\ Recipe.serving, order: .reverse))
                    
                    Text("Time (short to long)")
                        .tag(SortDescriptor(\ Recipe.time, order: .forward))
                    
                    Text("Time (long to short)")
                        .tag(SortDescriptor(\ Recipe.time, order: .reverse))
                }
            }
            .pickerStyle(.inline)
        }
    }
    
    @ViewBuilder
    private var content: some View {
        if recipes.isEmpty {
            empty
        } else {
            RecipesFiltterd(filter: query) {
                list(for: $0.sorted(using: sortOrder))
            }
        }
    }
    
    var empty: some View {
        ContentUnavailableView(
            label: {
                Label("No Recipes", systemImage: "list.clipboard")
            },
            description: {
                Text("Recipes you add will appear here.")
            },
            actions: {
                NavigationLink("Add Recipe", value: RecipeForm.Mode.add)
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
    
    private func list(for recipes: [Recipe]) -> some View {
        ScrollView(.vertical) {
            if recipes.isEmpty {
                noResults
            } else {
                LazyVStack(spacing: 10) {
                    ForEach(recipes){ recipe in
                        RecipeCell(recipe: recipe)
                    }
                }
            }
        }
        .searchable(text: $query)
    }
}

struct RecipesFiltterd<V>: View where V: View {
    
    var filter: String
    @Query private var recipes: [Recipe]
    @ViewBuilder var viewContent: ([Recipe]) -> V
    
    init(filter: String, @ViewBuilder label: @escaping ([Recipe]) -> V) {
        self.filter = filter
        self._recipes = Query(filter: #Predicate<Recipe>{
            if filter.isEmpty {
                return true
            }else{
                return $0.name.localizedStandardContains(filter) || $0.summary.localizedStandardContains(filter)
            }
        })
        self.viewContent = label
    }
    
    var body: some View {
        viewContent(recipes)
    }
}


