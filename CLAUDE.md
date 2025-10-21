# CLAUDE.md

## Project Overview

This repository contains a collection of retro games written in **Turbo Pascal 7.0** around 1995. These games were created by Marcin Stefaniak as learning projects during high school in Wisniew, Poland.

## Historical Context

- **Time Period**: 1994-1998
- **Purpose**: Educational - learning programming in high school and early university
- **Technology**: Turbo Pascal 7.0
- **Platform**: DOS

## Games Included

### Tasman
- **Type**: Boulder Dash-style game
- **Year**: 1995
- **Features**: Custom level editor (LEVEL.MST)
- **Credits**:
  - Program: Marcin Stefaniak
  - Graphics: Marcin Stefaniak, Magdalena Stefaniak
- **Location**: `/Tasman/`
- **Main File**: `TAS_MAN.PAS`

### Vertigo
- **Type**: Battleship-style game
- **Year**: November-December 1994
- **Gameplay**: Two-player game where each player selects a two-digit number and tries to guess the opponent's choice
- **Location**: `/Vertigo/`
- **Main File**: `VERTIGO.PAS`

### Wije
- **Type**: Snake game
- **Year**: 1995
- **Credits**: (C) 1995 by Emes Software, author: Marcin Stefaniak
- **Version**: 1.0
- **Location**: `/Wije/`
- **Main File**: `WIJE.PAS`

### Kreski
- **Type**: Snake-like game with simpler graphics
- **Year**: May 9, 1995
- **Note**: Created for Protas (IaLO 94/95, III LO in Siedlce)
- **Location**: `/Kreski/`
- **Main Files**: `KRESKI.PAS`, `KRESKIII.PAS`

### Szewc
- **Type**: Game created during university
- **Year**: 1998
- **Institution**: MIMUW (Faculty of Mathematics, Informatics and Mechanics, University of Warsaw)
- **Location**: `/szewc/`
- **Structure**: Multi-file project with modular design
  - `SZEWC.PAS` - main file
  - `TYPY.PAS` - types
  - `KOMPUTER.PAS` - computer player
  - `GRACZ.PAS` - human player
  - `OBSLUGA.PAS` - game handling
  - `EKRAN.PAS` - screen management

## Repository Structure

```
/Tasman/       - Boulder Dash clone with level editor
/Vertigo/      - Battleship-style guessing game
/Wije/         - Snake game
/Kreski/       - Simplified snake game
/szewc/        - University project game
/tasman2020/   - Modern version/update of Tasman
/screenshots/  - Game screenshots
```

## Technical Notes

### Language & Environment
- **Language**: Turbo Pascal 7.0
- **Common Module**: `MSTTP.PAS` - appears in multiple games as a shared utility module
- **File Extensions**: `.PAS` for Pascal source files, `.MST` for custom data formats

### Code Characteristics
- 1990s coding style and conventions
- DOS-era graphics and user interface
- Text-mode and simple graphics modes
- Direct hardware manipulation typical of the era

## Future Plans

From the README, there's a TODO to rewrite Tasman in HTML/JS or Swift/iOS.

## Working with This Code

When analyzing or modifying this code, keep in mind:

1. **Historical Code**: This is educational/historical code from 25+ years ago
2. **Turbo Pascal Syntax**: Uses Pascal conventions and Turbo Pascal-specific features
3. **DOS Era**: Code assumes DOS environment and hardware
4. **Character Encoding**: May contain Polish characters (ISO-8859-2 or similar)
5. **Educational Value**: Primary value is historical and educational rather than production use

## Language

- **Documentation**: Polish
- **Comments**: Likely Polish or mixed Polish/English
- **Variable Names**: May use Polish abbreviations or terms

## License & Copyright

(C) MSt VertigO, various years 1994-1998
Author: Marcin Stefaniak

---

*This file is intended to help AI assistants understand the context and structure of this repository.*
