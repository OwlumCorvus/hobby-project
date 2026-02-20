## Phase 1: Navigation
* **State**: Player spawns in a small, enclosed clearing. (prevents wandering)
* **UI Prompt**: Floating text or Center Screen: `"Tap to move"`
* **Logic**: Wait for `input_event` on the navigation map.
* **Success**: Player reaches `Marker2D_Step1`
## Phase 2: Social Interaction
* **State**: Once at marker, spawn `NPC_Guide`
* **UI Prompt**: `"Tap to talk"` (pointing at NPC)
* **Dialogue**: NPC: "I need a few things. Can you help me?"
  * Options: `[Yes / No ]` (Both lead to "Yes" because it's a tutorial!)
* **Action**: Add Quest Items to the world map.
## Phase 3: The Gathering
* **Items to Collect**:
  1. Stone (Teaches world interaction).
  2. Twine (Teaches pathfinding to a specific object)
* **UI Prompt**: `"Tap the items to collect them."`
## Phase 4: Inventory Management
* **State**: Items collected.
* **UI Prompt**: Flash the inventory icon (probably a bag in the corner)
* **Logic**: Check if `Inventory.size() == 2`
* **Dialogue**: `"Great! You have the items. Open your inventory to see them."`
