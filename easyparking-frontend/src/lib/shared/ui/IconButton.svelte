<script context="module" lang="ts">
  export type IconType = 'pencil' | 'trash' | 'star-inactive' | 'star-active';
</script>

<script lang="ts">
  export let icon: IconType;
  export let onClick: (event: MouseEvent) => void;

  const icons: Record<IconType, string> = {
    'star-inactive': `<g transform="matrix(0.025591, 0, 0, 0.025591, 3.963432, 3.963463)">
          <path d="M885.344,319.071l-258-3.8l-102.7-264.399c-19.8-48.801-88.899-48.801-108.6,0l-102.7,264.399l-258,3.8 c-53.4,3.101-75.1,70.2-33.7,103.9l209.2,181.4l-71.3,247.7c-14,50.899,41.1,92.899,86.5,65.899l224.3-122.7l224.3,122.601 c45.4,27,100.5-15,86.5-65.9l-71.3-247.7l209.2-181.399C960.443,389.172,938.744,322.071,885.344,319.071z"/>
        </g>`,
    'star-active': `<g transform="matrix(0.025591, 0, 0, 0.025591, 3.963432, 3.963463)">
          <path d="M885.344,319.071l-258-3.8l-102.7-264.399c-19.8-48.801-88.899-48.801-108.6,0l-102.7,264.399l-258,3.8 c-53.4,3.101-75.1,70.2-33.7,103.9l209.2,181.4l-71.3,247.7c-14,50.899,41.1,92.899,86.5,65.899l224.3-122.7l224.3,122.601 c45.4,27,100.5-15,86.5-65.9l-71.3-247.7l209.2-181.399C960.443,389.172,938.744,322.071,885.344,319.071z"/>
        </g>`,
    pencil: `<g transform="matrix(0.039807, 0, 0, 0.039807, 5.373878, 5.120311)">
              <path d="M328.883,89.125l107.59,107.589l-272.34,272.34L56.604,361.465L328.883,89.125z M518.113,63.177l-47.981-47.981 c-18.543-18.543-48.653-18.543-67.259,0l-45.961,45.961l107.59,107.59l53.611-53.611 C532.495,100.753,532.495,77.559,518.113,63.177z M0.3,512.69c-1.958,8.812,5.998,16.708,14.811,14.565l119.891-29.069 L27.473,390.597L0.3,512.69z"/>
            </g>`,
    trash: `<path d="M 14.59 7.889 C 14.196 7.883 13.875 8.201 13.875 8.595 L 9.653 8.595 C 9.11 8.587 8.762 9.17 9.027 9.644 C 9.153 9.869 9.394 10.009 9.653 10.004 L 22.348 10.004 C 22.891 10.012 23.239 9.429 22.974 8.955 C 22.847 8.729 22.607 8.591 22.348 8.595 L 18.125 8.595 C 18.125 8.201 17.804 7.883 17.411 7.889 L 14.59 7.889 Z M 9.653 11.416 L 9.653 22.7 C 9.653 23.479 10.284 24.111 11.063 24.111 L 20.937 24.111 C 21.717 24.111 22.348 23.479 22.348 22.7 L 22.348 11.416 L 9.653 11.416 Z" style=""/>`
  };

  const displayIcon = icons[icon];
</script>

<button class={icon} on:click|stopPropagation={onClick}>
  <svg
    class={icon}
    viewBox="0 0 32 32"
    width="32px"
    height="32px"
    xmlns="http://www.w3.org/2000/svg"
  >
    {@html displayIcon}
  </svg>
</button>

<style lang="scss">
  button {
    width: 32px;
    height: 32px;
    border: none;
    border-radius: 8px;
    background: rgb(162, 162, 175);
    z-index: 1;
    svg {
      cursor: pointer;
      &.star-inactive{
        fill: rgb(60, 60, 60);
      }
      &.star-active {
        fill: rgb(255, 255, 0);
      }
    }

    &:hover {
      background: rgb(190, 190, 203);
    }
  }
</style>
