#  Memory Visualizer Project Dashboard
  
This file outlines all tasks, subtasks, and milestones for managing the project.


---

## 🔹 Phase 1: Core Memory Inspection
**Goal:** Implement basic memory inspection for stack, heap, and global variables.

- **[ ] Implement stack memory dump**
  - [ ] Print stack addresses
  - [ ] Print stack contents in hex
  - [ ] Print stack contents in ASCII

- **[ ] Implement heap memory dump**
  - [ ] Allocate heap memory
  - [ ] Display heap content

- **[ ] Inspect global variables**
  - [ ] Print data/bss segments

---

## 🔹 Phase 2: Dynamic Memory Visualization
**Goal:** Track memory changes live and enable user interaction.

- **[ ] Live stack monitoring**
  - [ ] Poll stack memory periodically
  - [ ] Highlight changes from previous dump

- **[ ] Live heap monitoring**
  - [ ] Track heap allocations/deallocations
  - [ ] Visualize changes

- **[ ] Add user CLI input**
  - [ ] `view <segment> <address> <length>`
  - [ ] `dump <segment> <file>`

---

## 🔹 Phase 3: Advanced Features
**Goal:** Implement registers mapping, step-through instructions, and conditional watches.

- **[ ] Map CPU registers**
  - [ ] Display `RAX, RBX, RCX, RDX, RSP, RIP` live

- **[ ] Step-through instructions**
  - [ ] Display current instruction at `RIP`
  - [ ] Update memory visualization after each instruction

- **[ ] Conditional memory watches**
  - [ ] Trigger alerts when memory changes

---

## 🔹 Phase 4: CLI & User Experience
**Goal:** Make CLI interactive and user-friendly.

- **[ ] Implement commands**
  - [ ] `view`
  - [ ] `dump`
  - [ ] `watch`
  - [ ] Command help menu

- **[ ] Improve memory output formatting**
  - [ ] Color code stack/heap/data
  - [ ] ASCII + hex side-by-side

- **[ ] Add examples**
  - [ ] `examples/demo1.asm`
  - [ ] Document example usage

---

## 🔹 Phase 5: Optional GUI / Visualization
**Goal:** Build a GUI for live memory visualization.

- **[ ] Create Python GUI prototype**
  - [ ] Tkinter window to display memory
  - [ ] Color-coded memory blocks
  - [ ] Step-through instruction display

- **[ ] Integrate with ASM output**
  - [ ] Pipe memory dumps to GUI

---
