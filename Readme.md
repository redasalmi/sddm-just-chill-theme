# Just Chill Theme

A simple theme to log into your computer and just chill

![just chill theme preview](./assets/preview.png)

## Dependencies

- SDDM
- Qt 5
- Qt Quick Controls 2
- Qt SVG

## Installation

### Manually

```
  git clone https://github.com/redasalmi/sddm-just-chill-theme.git
  cd sddm-just-chill-theme/
  sudo cp -r sddm-just-chill-theme/ /usr/share/sddm/themes/
```

## Configuration

After copying the theme, you should set it in the `/etc/sddm.conf` or your sddm configuration file to use it with the following command:

```
  echo "[Theme]\nCurrent=sddm-just-chill-theme" | sudo tee /etc/sddm.conf
```
