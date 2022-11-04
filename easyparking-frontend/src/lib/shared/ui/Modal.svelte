<script lang="ts">
    export let open;
    export let closeOnOutsideClick = true;
    export let onCloseCallback: (event: Event) => void;

    let modalOverlay: Node;

    const onClose = (event: Event) => {
        if(modalOverlay.isSameNode(event.target as Node) && closeOnOutsideClick) {
            onCloseCallback(event);
        }
    };
</script>
{ #if open }
    <div class="modal-overlay" on:click={onClose} bind:this={modalOverlay}>
            <div class="modal-main">
                <slot></slot>
            </div>
    </div>
{/if}

<style lang="scss">
    .modal-overlay {
      display: flex;
      justify-content: center;
      align-items: center;
      position: fixed;
      left: 0;
      top: 0;
      height: 100vh;
      width: 100vw;
      background: rgb(0, 0, 0);
      opacity: 50%;
      z-index: 1000;

      .modal-main {
        opacity: 100%;
        z-index: 1001;
        height: min-content;
        width: min-content;
        padding: 25px;
        border: rgb(107, 107, 133) 1px solid;
        border-radius: 10px 10px 10px 10px;
        background: rgb(107, 107, 133);
      }
    }
</style>