## Dépannage

### Erreur EXT4 sur NixOS

Si le menu de secours du stage 1 de NixOS s'affiche lors du démmarage du PC avec ce message 

```
<<< NixOS Stage 1 >>>

loading module amdgpu...
loading module dm_mod...
running udev...

An error occurred in stage 1 of the boot process, which must mount the
root filesystem on `/mnt-root` and then start stage 2.  Press one
of the following keys:

  i) to launch an interactive shell
  f) to start an interactive shell having pid 1 (needed if you want to start stage 2's init manually)
  r) to reboot immediately
  *) to ignore the error and continue
```

Pas de panique ! Des erreurs se sont produites sur une partition du disque sur lequel NixOS à été installé.
Cela peut arriver si vous avez arrêté brusquement le système (arrêt forcé ou coupure du courrant).
Vous pouvez toujours démarrer le système en appuyant sur n'importe quelle autre touche affichée.

Pour supprimer le menu de récupération au démarrage, vous devez réparer la partition du disque à l'origine de l'erreur:

1) Appuyez sur la touche `f` lorsque le menu de dépannage apparait.
2) Identifiez la partition à l'origine du problème. Pour ce faire, nous allons ouvrir le journal système à l'aide de la commande:
```bash
journalctl -r -g "warning: mounting fs with errors"
```

Vous devriez voir les lignes suivantes:
```bash
-- Boot 31f0818c037f459e830269397e4e9ed4 --
-- Boot f07aabbfa04849be97b70e0dfc85291b --
avril 22 17:55:21 Roazhon kernel: EXT4-fs (nvme0n1p2): warning: mounting fs with errors, running e2fsck is recommended
-- Boot 69d8a9980ef044d6abfd792e3cd4bb3e --
avril 22 09:53:55 Roazhon kernel: EXT4-fs (nvme0n1p2): warning: mounting fs with errors, running e2fsck is recommended
-- Boot e21ca4e537534b828322931d2eab6259 --
avril 21 21:04:34 Roazhon kernel: EXT4-fs (nvme0n1p2): warning: mounting fs with errors, running e2fsck is recommended
-- Boot 2890c206fef04dff9c180e952121ac18 --
avril 20 21:55:14 Roazhon kernel: EXT4-fs (nvme0n1p2): warning: mounting fs with errors, running e2fsck is recommended
-- Boot ed52cb6e10834d1abd625775f715cdd5 --

...
```
Dans l'exemple ci-dessus, c'est la partition `nvme0n1p2` qui cause le problème.
Appuyez sur `q` pour fermer le journal.

3) Vérifiez que la partition du stockage est bien détecté par le système.
```bash
cat /proc/partitions
```

4) Lancez l'outil pour réparer la partition endommagée identifiée dans le journal système
```bash
e2fsck -f -y -v /dev/nvme0n1p2
```

5) Relancez le programme de démarrage du système.
```bash
exec /init
```

6) Si le menu de dépannage réapparait, appuyez sur `r` pour redémarrer. Le menu de récupération ne s'affichera plus.
