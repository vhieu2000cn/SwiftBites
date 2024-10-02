import SwiftUI
import SwiftData

struct IngredientForm: View {
    enum Mode: Hashable {
        case add
        case edit(Ingredient)
    }
    
    var mode: Mode
    
    init(mode: Mode) {
        self.mode = mode
        switch mode {
        case .add:
            _name = .init(initialValue: "")
            title = "Add Ingredient"
        case .edit(let ingredient):
            _name = .init(initialValue: ingredient.name)
            title = "Edit \(ingredient.name)"
        }
    }
    
    private let title: String
    @State private var name: String
    @State private var error: Error?
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isNameFocused: Bool
    
    // MARK: - Body
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $name)
                    .focused($isNameFocused)
            }
            if case .edit(let ingredient) = mode {
                Button(
                    role: .destructive,
                    action: {
                        delete(ingredient: ingredient)
                    },
                    label: {
                        Text("Delete Ingredient")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                )
            }
        }
        .onAppear {
            isNameFocused = true
        }
        .onSubmit {
            save()
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save", action: save)
                    .disabled(name.isEmpty)
            }
        }
    }
    
    // MARK: - Data
    
    private func delete(ingredient: Ingredient) {
        context.delete(ingredient)
        dismiss()
    }
    
    private func save() {
        do {
            switch mode {
            case .add:
                try addIngredient(name: name)
            case .edit(let ingredient):
                try updateIngredient(id: ingredient.id, name: name)
            }
            dismiss()
        } catch {
            self.error = error
        }
    }
    
    private func addIngredient(name: String) throws {
        let fetchDescriptor = FetchDescriptor<Ingredient>()
        let ingredients = try? context.fetch(fetchDescriptor)
        guard ingredients?.contains(where: { $0.name == name }) == false else {
            throw SwiftBitesModelContainer.Error.ingredientExists
        }
        context.insert(Ingredient(name: name))
    }
    
    private func updateIngredient(id: UUID, name: String) throws{
        let fetchDescriptor = FetchDescriptor<Ingredient>(predicate: #Predicate { $0.id == id  })
        let ingredient = try? context.fetch(fetchDescriptor)
        guard let firstIngredient = ingredient?.first else {
            throw SwiftBitesModelContainer.Error.ingredientExists
        }
        firstIngredient.name = name
        try? context.save()
    }
}
