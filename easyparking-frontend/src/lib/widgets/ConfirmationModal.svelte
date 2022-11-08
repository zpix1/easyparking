<script lang="ts">
  import Modal from "../shared/ui/Modal.svelte";
  import Button from "../shared/ui/Button.svelte";

  export let open;
  export let onClose: () => void;
  export let onConfirm: () => void;
</script>

<Modal {open} onCloseCallback={onClose}>
  <div class="confirmation-modal">
    <p>Do you want to delete parking?</p>
    <div class="confirmation-buttons">
      <Button onClick={onConfirm}>Confirm</Button>
      <Button onClick={onClose}>Cancel</Button>
    </div>
  </div>
</Modal>

<style>
  .confirmation-modal {
    display: flex;
    flex-flow: column nowrap;
    row-gap: 1rem;
  }

  .confirmation-buttons {
    display: flex;
    flex-flow: row nowrap;
    column-gap: 1rem;
  }
</style>
