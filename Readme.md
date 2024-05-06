# Godot Project Template by BD21

Contained in this repository are custom nodes for easing your game development experience in Godot.

## Installation

1. **Download:** Clone this repository or download the ZIP file and extract it.
2. **Execute:** Run the `project.godot` file.
3. **Copy:** To copy the custom nodes to an existing project, simply copy the CUSTOM_NODES folder to your project's root directory. Check how to use in the usage section below.

## Usage

To use this template in an existing project, simply copy the `CUSTOM_NODES` folder to the root of your project folder. To use a custom node, simply instance it as a scene in the 2D editor.

![Instantiate child scene]("[[https://drive.google.com/file/d/1GHnMIzbztLLWqyrhm1-PpseAbyIUVoFA/view?usp=sharing](https://imgur.com/a/PZFGM8R)](https://imgur.com/a/PZFGM8R)")

## Features

**CustomBtn:**
- influence parent: Parent of the button reacts to the `button_pressed` or `button_released` signal.
- down trans type: The trans type to use when tweening on the `button_pressed` signal.
- up trans type: The trans type to use when tweening on the `button_released` signal.
- down trans ease: The ease type to use when tweening on the `button_pressed` signal.
- up trans ease: The ease type to use when tweening on the `button_released` signal.

**BlurBG:**
- blur color
- amount
- duration: The duration of tweening the node in or out.

**CustomAcceptDialog:**
- title: The text to be displayed on the heading section of the dialog.
- content: The main content of the dialog.
- primary text: The text to be displayed on the primary button of the dialog.
- secondary text: The text to be displayed on the secondary button of the dialog.

**CustomBtnAnimated:**
  The animated version of the `CustomBtn` node. This includes hover, focus entered, focus exited, button down and button up animations.

**CustomGridContainer, CustomHBoxContainer:**
- child added trans type: The trans type to use when tweening on `child_entered`.
- child exited trans type: The trans type to use when tweening on `child_exited`.
- in duration: The tween duration of `on_child_entered`.
- out duration: The tween duration of `on_child_exited`.

## License

This project is licensed under the [MIT License](LICENSE).

## About

This addon was created by [Baltai Daniel](https://github.com/BaltaiDaniel).
