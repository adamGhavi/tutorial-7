## Report
For this tutorial I was tasked to create a simple 3D platformer using the Godot engine. I was able to follow the steps in the tutorial and create:
1. a simple 3D level,
2. a switch that controls in-game lighting,
3. rudimentary 3D models using the () system,
4. a basic 3D movement and camera system, and
5. a level-end system

## Additional Mechanics
Besides that, I was also given the opportunity to choose between 2 FPS mechanics to implement into the game:
-an inventory system, or
-a crouch/sprint system.

I chose the crouch/sprint system as I was previously familiar of how these movement systems are implemented. I created a state machine containing the states: "normal", "crouching", and "sprinting". I've expanded upon the "max speed" variable and added respective maximum speeds for each state. As you might expect, the maximum speed for the "crouching" state is slower and the maximum speed for the "sprinting" state is higher. Besides this, I've made it so that the camera's gaze lowers during the "crouching" state and that the player is able to perform a "crouch-jump" mechanic that increases their jump height. And for the "sprinting" state, I've implemented a simple stamina system that depletes when the player sprints and slowly replenishes over time.

Additionally, I created a second level with a more vertical layout than the first and simple obstacles to challenge the player.
