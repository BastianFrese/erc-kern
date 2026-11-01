# ERC Kern — geänderte Fassung der Swofty-Launcher-Kern-CLI

Dieses Repository enthält **nur die Änderungen** an der Kern-CLI von
[Swofty Launcher](https://github.com/Swofty-Developments/SwoftyLauncher) und die Anleitung,
wie die daraus gebaute `swofty.exe` entsteht. Der ERC Launcher liefert diese Datei in seinem
Installer mit.

## Warum

Der Kern schreibt beim Bauen der Mods zwei Texte in die Spieloberfläche, die von einem
anderen Projekt sprechen. Für eine Liga, die ihren eigenen Launcher ausliefert, gehören dort
ihre eigenen Namen hin. Mehr wird nicht verändert.

| Datei | vorher | jetzt |
|---|---|---|
| Startbildschirm, Untertitel | `Launched with Swofty Launcher` | `Gestartet mit dem ERC Launcher` |
| Hinweisfenster im Spiel | `Swofty Mod v<fassung>` mit Liste „New in v…" | `ERC Mod` mit einem Satz zur ERC-Lobby |
| Einwilligung vor dem Start | Bedingungen werden beim Start abgefragt | entfällt — der ERC Launcher kümmert sich selbst darum |

> [!warning] **Mit der dritten Änderung fällt die Einwilligung vor dem Start weg.**
> Spieler sehen damit nicht mehr den Hinweis, dass modifiziertes Fahren ohne EA
> AntiCheat außerhalb der EA-Bedingungen liegt und EA Konten belangen kann. Das ist eine
> bewusste Entscheidung des Betreibers. `swofty offline status`, `accept` und `withdraw`
> funktionieren weiterhin.

Alles andere — Spielstart, Mod-Verwaltung, Netzwerkweg — bleibt unverändert.

## Lizenz

Swofty Launcher steht unter **AGPL-3.0-or-later** (siehe [LICENSE](LICENSE)),
Copyright (C) 2026 Jacob Nardella (Swofty). Diese geänderte Fassung wird unter denselben
Bedingungen weitergegeben. Der vollständige Quelltext ist der Quelltext des genannten
Projekts **plus** [aenderungen.patch](aenderungen.patch) in diesem Repository.

## Bauen

Voraussetzungen: Rust 1.95 (siehe `rust-toolchain.toml` des Projekts) und ein C++-Werkzeugsatz
für die mitgelieferten DLLs — für die CLI selbst genügt Rust.

```powershell
# 1. Quelltext der veröffentlichten Fassung holen
git clone --depth 1 --branch v1.7.5 https://github.com/Swofty-Developments/SwoftyLauncher.git
cd SwoftyLauncher

# 2. Diese Änderungen anwenden
git apply ..\aenderungen.patch

# 3. Die CLI bauen (nur sie wird gebraucht)
cargo build --release -p swofty-cli

# 4. Ergebnis: target\release\swofty.exe
.\target\release\swofty.exe --version
```

Das Ergebnis ersetzt im ERC Launcher die Datei `kern\bin\swofty.exe`. Die übrigen Teile des
Kerns (`dxc`, `loader`) bleiben die unveränderten Dateien der veröffentlichten Fassung.

`bauen.ps1` macht dieselben Schritte in einem Rutsch.
