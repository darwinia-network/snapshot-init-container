# Snapshot Init Container

![](https://img.shields.io/github/workflow/status/darwinia-network/snapshot-init-container/Production)
![](https://img.shields.io/github/v/release/darwinia-network/snapshot-init-container)

A Kubernetes init container that downloads and extracts chain database snapshots to boost up node initializations.

## About Snapshots

Check out our Wiki page to learn more about the Darwinia and Crab Network database snapshots: <https://github.com/darwinia-network/darwinia/wiki/Darwinia-and-Crab-Network-Database-Snapshot>.

## Usage

Add `quay.io/darwinia-network/snapshot-init-container` as an init container in your Kubernetes manifests and fill the correct values to the environment variables:

```yaml
volumes:
  - name: snapshot
    emptyDir: {}

initContainers:
  - name: init-snapshot
    # Replace <VERSION> to one of the GitHub releases.
    image: quay.io/darwinia-network/snapshot-init-container:<VERSION>
    volumeMounts:
      # Mount an emptyDir volume on /snapshot helps continue downloading if the init container restarted.
      - name: snapshot
        mountPath: /snapshot
      # Do not forget to mount the chain database volume.
      - name: data
        mountPath: /data
    env:
      #
      # Required, the URL of the snapshot archive
      # Supported file types:
      #
      # - Gzip tar (URL must ends with .tar.gz)
      # - Zstandard tar (URL must ends with .tar.zst)
      # - 7-Zip (URL must ends with .7z)
      #
      - name: ARCHIVE_URL
        value: http://exmaple.com/snapshot.tar.gz

      #
      # Required, the path of chain directory
      # Example (assume with the node CLI option `--base=/data`):
      #
      # - Kusama Network:   /data/chains/ksmcc3
      # - Polkadot Network: /data/chains/polkadot
      # - Darwinia Network: /data/chains/darwinia
      # - Crab Network:     /data/chains/crab
      #
      - name: CHAIN_DIR
        value: /data/chains/polkadot

      #
      # Optional, if set, `chmod -R $CHMOD` will be used to reset the permissions of "db" directory
      # Example: "777"
      #
      - name: CHMOD
        value: "777"

      #
      # Optional, if set, `chown -R $CHOWN` will be used to reset owners (and groups) of "db" directory
      # Example: 1000:1000
      #
      - name: CHOWN
        value: 1000:1000
```

## Integration with Kubevali

See <https://github.com/darwinia-network/kubevali/blob/master/deploy/manifests/statefulset.yaml>.

## Credits

- <https://github.com/midl-dev/polkadot-k8s/tree/master/docker/polkadot-archive-downloader>
