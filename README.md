# Raven

## Introduction
Raven is a UI library for GameMaker designed to simplify the process of creating responsive UIs for your projects. This library aims to provide an intuitive way to create panels and UI elements while maintaining flexibility and customizability.


If you're looking for a framework with recursive setup and nesting of components, consider checking out the "Emu" UI framework created by community member DragoniteSpam. Sooo.. Why use Raven?

# Key Features:

- Responsive: Raven helps you design responsive UIs that adapt to different screen sizes and orientations.
- Minimal: With Raven, you can create UIs with minimal effort, reducing the complexity of UI design.
- Flexible: Raven's customizable components allow you to create a variety of UI layouts to suit your game's needs.
- Maintainable: The library promotes a structured approach to UI development, making it easier to manage and maintain your UI code.
- Customizable: Customize UI elements to match your game's aesthetic and design.


<img width="400" alt="menu1" src="https://github.com/Emperor2000/Raven/assets/38536470/e7b89cd8-37b5-4e4d-860c-c0855dafd51b">


Raven allows you to create UI's at different resolutions and have a responsive UI when scaling containers or the game window.


## Getting Raven

To get started with Raven, you'll need to download it from the [Raven GitHub Repository](https://github.com/Emperor2000/Raven). Once downloaded, you can import the repository into GameMaker as a project or package. This will make the Raven assets and scripts available for use in your project.

### Initializing the UI

After setting up Raven in your project, navigate to the `obj_raven_init` object. In the `Create Event` of this object, you'll find a "//GET STARTED HERE" section. This is where you'll initialize the UI components and start building your interface.

### Creating the Core Struct

The cornerstone of Raven is the core struct instance, which manages the UI elements and interactions. You can create the main/core struct using the following code:

```javascript
raven = new RavenMain();
```
The above code instantiates a new RavenMain struct, which will be our main/core object, this can be seen as the controller to any raven-driven UI.

```javascript
menu = new RavenMenu(0, 0, 64, 32, 32);
overview_button = new RavenItem("Overview", noone);
new_button = new RavenItem("New", noone);

menu.AddItem(overview_button);
menu.AddItem(new_button);
```
The above code results in a menu with several items in it. 
While we are working on this menu we are also able to customize it, let's add an outline!
```javascript
menu.SetOutline(true);
```
now that we have our menu, we just need to add it to our main struct.

```javascript
raven.SetMenu(menu);
```
We now establish this menu to be updated and rendered during runtime.

Now that we have established a menu and main struct for our project we might want to add a panel/tab somewhere. In order to do this we can make a container.
```javascript
container = new RavenContainer(0, 0, global.resolution_x, global.resolution_y, true, false);
container.SetLock(true);
```
We have created a container and locked it. This means the container can not be resized, dragged, etc. We have not yet added our container to the main struct, let's do that!
```javascript
raven_gui.AddContainer(container);
```
We can also create a smaller panel, for example in order to display tooltips or serve as a sidebar or overlay:
```javascript
var tooltip_container = new RavenContainer(200, 200, 600, 600, false, true, gui_render_mode.VLIST, 3);
var container_menu = new RavenMenu(0, 0, 64, 32, 32);
tooltip_container.SetMenu(container_menu);
```
As you can see in the above code, each container can also have it's own menu. All that we are missing now is some text to display in our tooltipcontainer!
```javascript
tooltipcontainer.AddItem(new RavenTextItem("This is a TextField", 0, 16, fnt_dsansmono16));
tooltipcontainer.AddItem(new RavenTextItem("Let's write a paragraph! The quick brown fox jumps over the lazy dog.", 0, 16, fnt_dsansmono16));
```
And we finalize by adding our tooltipcontainer to our main struct.
```javascript
raven.AddContainer(tooltip_container);
```
That's it for getting started!


Here are a few examples to what you could simply create with Raven:


<img width="294" alt="scaling1" src="https://github.com/Emperor2000/Raven/assets/38536470/1ff4355f-03c7-479d-ab1d-1e02e3a4b682">


As you can see we are also able to scale our UI, and text, buttons and elements will adapt to the new layout. 


<img width="919" alt="theme2" src="https://github.com/Emperor2000/Raven/assets/38536470/db52bac1-021e-4afc-b3f6-ef4305fda904">


You can select a few different themes, or easily make your own!



## Components
Raven provides a set of components for creating dynamic and responsive GUI's in GameMaker. Components include containers (panels), menuss, checkboxes, text input fields, dropdowns, text fields and much more.
# [V0.4.0]
- RavenMain : Main component which controls and updates all components in the framework.
- RavenMenu : A component that you can insert into containers, to give them a menu bar and make them controllable.
- RavenContainer : A central building block of the framework. Use this to create the layout for your application. You can use several variants of this RavenContainer to automatically render in lists or grids, or position everything yourself.
- RavenTextItem : A single line of text, any text outside of the container is hidden. This element is responsive to altering container dimensions.
- RavenMultilineTextItem : A multiline text, any text outside of the container is shifted to the next line, again and again. This element is responsive to altering container dimensions.
- RavenItem : The main button used for menu items. This also is a parent to many other items. This element should shift and move to the next line if it does not fit in your container anymore.
- RavenLineBreakItem : An empty space to separate content, defined by a margin when rendered by a container, or a height in the item itself.
- RavenCheckboxItem: A simple checkbox item. Shows a string with a checkbox (true or false) value behind it.
- RavenTextInputItem : An experimental element that allows you to type text into a field. Please note that this item is a work in progress, and may have some unexpected behavior.
- RavenDropdownItem : An experimental element that allows you to show options in a dropdown, and select an item. Please note that this element may have some unexpected behavior.
# [V0.5.0]
- RavenButtonItem : A button with optional padding and rounded corners that can be displayed in a container.
- RavenImageButtonItem : A clickable image/sprite with optional scaling parameters for width and height that can be displayed in a container.




