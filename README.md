# Raven

## Introduction

Raven is a UI framework for GameMaker. It is something I set out to make as a challenge, something I have learned a lot from. This framework isn't perfect and still a huge work in progress, but I hope to have delivered a system with this that at least can make the process of making UI's a bit easier in GameMaker.
I expect to be regularly updating this framework for the upcoming time to flesh it out more and realise a minimum set of functionalities I have envisioned. I have decided to make the current version public so that anyone interested can follow development and experiment with it.
Raven allows you to create panels and UI elements with hopefully a minimal amount of effort and in an easy to understand way. At first I was planning to make a UI framework that would allow adding items recursively, with indefinite subcontainers and items. But apart from the huge amount of extra work that would give me, I found out that something like that already exists while I was working on this. User DragoniteSpam has developed an incredible UI framework called "Emu". Emu is far more sophisticated than Raven, and something I would not dare set out to rival. Both frameworks being birds is a weird coincidence I promise! :)

it is good to mention that this framework is very much experimental and a work in progress. Feel free to give it a try, but I hope you understand that you might still encounter breaking issues and problems during use. I ultimately hope to realise Raven as a go-to UI system for GameMaker that is stable, robust and flexible.

Raven is envisioned to be:
Responsive
Minimal
Flexible
Maintainable
Extendable
Customizable


## Components
Raven provides a set of components for creating dynamic and responsive GUI's in GameMaker. Components include containers (panels), menuss, checkboxes, text input fields, dropdowns, text fields and much more.

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

Raven allows you to create UI's at different resolutions and have a responsive UI when rescaling images.

<img width="916" alt="menu1" src="https://github.com/Emperor2000/Raven/assets/38536470/e7b89cd8-37b5-4e4d-860c-c0855dafd51b">

As you can see we are also able to scale our UI, and text, buttons and elements will adapt to the new layout. 
<img width="294" alt="scaling1" src="https://github.com/Emperor2000/Raven/assets/38536470/1ff4355f-03c7-479d-ab1d-1e02e3a4b682">

Raven also allows you to use different themes and replace them with your own preferred styles.
<img width="919" alt="theme2" src="https://github.com/Emperor2000/Raven/assets/38536470/db52bac1-021e-4afc-b3f6-ef4305fda904">

