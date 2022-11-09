<script lang="ts">
  export let type = '';
  export let onClick: () => void;
</script>

<button {type} on:click={onClick}>
  <slot />
</button>

<style lang="scss">
  button {
    display: block;
    font: inherit;
    cursor: pointer;
    color: var(--color-text);
    background: #2b2a53
      linear-gradient(45deg, rgba(160, 158, 240, 0.7) 50%, transparent 50%) 100%;
    background-size: 400%;
    transition: background 0.3s ease, filter 0.7s ease;
    padding: 0.5rem 1.75rem;
    border: 5px solid #a09ef0;
    border-radius: 50px;
    text-align: center;
    text-transform: uppercase;
    &:hover {
      background-position: 0;
      filter: drop-shadow(5px 5px 20px #a09ef0) drop-shadow(-5px -5px 10px #831dd6);
    }
  }
</style>
