//
//  MainMenu.swift
//  SwiftUIPlayground
//
//  Created by Anthony Da cruz on 07/06/2022.
//

import SwiftUI

struct ViewItem {
    let label: String
    let view: AnyView
    var isNew = false
}



enum ViewsIndex: CaseIterable {
    case bottomSheet, sizeClass, haptic, permissions, localNotifications, scrollViewFixedElement, lazyGridViewWithImages, gradientOnImage, animation, mapKit, mapKitLocation, networkMonitor
    
    func viewForCase() -> ViewItem {
        switch self {
        case .bottomSheet:
            return ViewItem(label: "Bottom Sheet", view: AnyView(iOS16BottomSheet()), isNew: true)
        case .sizeClass:
            return ViewItem(label: "Size Class Sample", view: AnyView(SizeClassView()))
        case .haptic:
            return ViewItem(label: "Haptic Playground", view: AnyView(Haptic()))
        case .permissions:
            return ViewItem(label: "Permission Combine", view: AnyView(PermissionsWithCombine()))
        case .localNotifications:
            return ViewItem(label: "Local Notifications", view: AnyView(LocalNotificationView()))
        case .scrollViewFixedElement:
            return ViewItem(label: "Scroll View Fixed element", view: AnyView(ScrollViewFixedElement()))
        case .lazyGridViewWithImages:
            return ViewItem(label: "Lazy Grid View With Images", view: AnyView(LazyGridView()))
        case .gradientOnImage:
            return ViewItem(label: "Gradient on Image", view: AnyView(GradientOnImage()))
        case .animation:
            return ViewItem(label: "Animation", view: AnyView(AnimationPlayground()))
        case .mapKit:
            return ViewItem(label: "MapKit", view: AnyView(MapView()))
        case .mapKitLocation:
            return ViewItem(label: "MapKit with Location", view: AnyView(MapKitWithLocation(annotationsItems: annotationItemsFromRawRegion, selectedItem: .constant(nil))))
        case .networkMonitor:
            return ViewItem(label: "Dynamic Network monitoring", view: AnyView(NetworkMonitorView()))
        }
    }
    
}

struct MainMenu: View {
    @State private var presentedView:[ViewsIndex] = []
    @State private var selectedItem: ViewsIndex?
    
    var body: some View {
        NavigationStack(path: $presentedView) {

            List(ViewsIndex.allCases, id: \.self) { viewIndex in
                let viewItem = viewIndex.viewForCase()
                NavigationLink(value: viewIndex) {
                    HStack {
                        viewItem.isNew ? Text("🆕") : Text("‣")
                        
                        Text(viewItem.label)
                    }
                }
            }.navigationDestination(for: ViewsIndex.self) { item in
                item.viewForCase().view
            }
            .navigationTitle(Text("🛝 Swift Playground"))
            .toolbar {
                ToolbarItem {
                    Button {
                        presentedView = [ViewsIndex.haptic, ViewsIndex.gradientOnImage]
                    } label: {
                        Text("Test Navigation Stack")
                    }
                }
            }
        }
    }
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}