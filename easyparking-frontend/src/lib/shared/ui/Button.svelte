<script lang="ts">
    type ButtonSize = "s" | "m" | "l" | "xl";

    export let type = '';
    export let size: ButtonSize = "s";
    export let onClick: () => void;
</script>

<button {type} class={size} on:click={onClick}>
    <slot />
</button>

<style lang="scss">
  button {
    display: block;
    font: inherit;
    cursor: pointer;
    color: var(--color-text);
    background: #2b2a53 linear-gradient(
                    45deg,
                    rgba(160, 158, 240, 0.7) 50%,
                    transparent 50%
    ) 100%;
    background-size: 400%;
    transition: background 0.3s ease, filter 0.7s ease;
    border: 5px solid #a09ef0;
    border-radius: 50px;
    text-align: center;
    text-transform: uppercase;

    &.s {
      padding: .5rem 1.75rem;
    }

    &.m {
      padding: .7rem 3rem;
    }

    &.l {
      padding: .9rem 4.25rem;
    }

    &.xl {
      padding: 1.1rem 6rem;
    }

    &:hover {
      background-position: 0;
      filter: drop-shadow(5px 5px 20px #a09ef0)
        drop-shadow(-5px -5px 10px #831dd6);
    }
  }
  @media (max-width: 1091px) {
  }
  @media (max-width: 768px) {
  }
  @media (max-width: 426px) {
  }
</style>
