if status is-interactive
# Commands to run in interactive sessions can go here
    fastfetch --config config-violet.jsonc
end
# Keine Willkommensnachricht
set -g fish_greeting ""

function shd
    shutdown 0
end

function faf
    fastfetch --config config-violet.jsonc
end

function c
    clear && fastfetch --config config-violet.jsonc
end

# Farben definieren
set GREEN (set_color green)
set NC (set_color normal)

function nx-rebuild
    echo "$GREEN🔧 Starte nixos-rebuild switch...$NC"

    cd /etc/nixos; or return

    sudo nixos-rebuild switch --flake .#nixos; or return

    cd - >/dev/null
    echo "$GREEN✅ Rebuild erfolgreich abgeschlossen!$NC"
end

function nx-gens
    echo "$GREEN📜 Verfügbare System-Generationen:$NC"
    sudo nixos-rebuild list-generations
    echo "$GREEN✨ Fertig.$NC"
end

function nx-niri
    sudo nano ~/.config/niri/config.kdl
end

function nx-cd
    cd /etc/nixos/
end


function gif
    if test -z "$argv[1]"
        echo "Usage: gif <name> [-n]"
        return 1
    end

    set cmd "python3 ~/Scripts/chika.py ~/Scripts/$argv[1].gif"

    if test "$argv[2]" = "-n"
        nohup nix-shell -p "python3.withPackages (ps: with ps; [ pygobject3 pillow ])" \
            gtk3 gtk-layer-shell gobject-introspection \
            --run "$cmd" >/dev/null 2>&1 &
		disown
    else
        nix-shell -p "python3.withPackages (ps: with ps; [ pygobject3 pillow ])" \
            gtk3 gtk-layer-shell gobject-introspection \
            --run "$cmd" &
    end
end

# Autocomplete für gif (Fish-kompatibel)
# Alte gif Completions entfernen
complete -c gif -e

# Funktion, die nur die Dateinamen aus ~/Scripts zurückgibt
function _gif_files
    for f in ~/Scripts/*.gif
        if test -e $f
            # Nur Name, ohne Pfad und ohne .gif
            echo (basename $f .gif)
        end
    end
end

# Erstes Argument: nur die GIF-Dateien aus ~/Scripts
complete -c gif \
    -n "test (count (commandline -opc)) -eq 1" \
    -a "(_gif_files)" \
    -f

# Zweites Argument: nur -n
complete -c gif \
    -n "test (count (commandline -opc)) -eq 2" \
    -a "-n" \
    -f

function nx-tree
    echo -e "$GREEN\033[1;32m🌳 NixOS Struktur in /etc/nixos:\033[0m"

    if not cd /etc/nixos
        return
    end

    if type -q tree
        tree -L 2 -I '*.lock|*.save'
    else
        echo -e "$GREEN\033[1;33mtree nicht installiert – nutze ls:\033[0m"
        ls -R
    end

    cd - >/dev/null
end


function nx-update
    echo "$GREEN🚀 Starte Flake Update..."

    if not cd /etc/nixos
        return
    end

    sudo nix flake update; or return
    sudo nixos-rebuild switch --flake .#nixos; or return

    cd - >/dev/null
    echo "$GREEN✅ System erfolgreich aktualisiert!"
end

function nx-fullupdate
    echo "$GREEN🚀 Starte Flake Update..."

    if not cd /etc/nixos
        return
    end

    sudo nix flake update; or return
    sudo nixos-rebuild switch --flake .#nixos; or return

    cd - >/dev/null

    echo "$GREEN Das Flatpak nicht vergessen :)"

    flatpak update -y

    echo "$GREEN✅ System erfolgreich aktualisiert!"
end

function nx-edit
    if test -z "$argv[1]"
        echo "$GREEN⚠ Bitte eine Datei angeben (z.B. configuration.nix)"
        return 1
    end

    set fullpath "/etc/nixos/$argv[1]"

    if not test -f "$fullpath"
        echo "$GREEN❌ Datei nicht gefunden: $fullpath"
        return 1
    end

    sudo nano "$fullpath"
end

# Alte nx-edit Completions entfernen
complete -c nx-edit -e

# Nur Dateien aus /etc/nixos anbieten (keine cd-Vorschläge)
complete -c nx-edit \
    -a "(find /etc/nixos -type f -name '*.nix' -printf '%f\n')" \
    -f

function nx-clean
    echo "$GREEN🧹 Behalte die letzten 5 System-Generationen..."

    sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +5; or return

    echo "$GREEN🗑️ Starte Garbage Collection..."

    sudo nix-collect-garbage; or return

    echo "$GREEN✨ Cleanup erfolgreich abgeschlossen!"
end
