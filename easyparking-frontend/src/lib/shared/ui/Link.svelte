<script>
  export let text = "default";
  export let to = "/";
  export let size = "m";
  export let classNames = "default";
  export let external = false;
</script>

<a
  class={`${classNames} ${size === "l" ? "size-l" : "size-m"}`}
  href={to}
  target={external ? "_blank" : ""}
>
  {text}
</a>

<style lang="scss">
  a {
    &.default {
      position: relative;
      text-decoration: none;
      color: var(--color-text);
      cursor: pointer;
      &.shifted {
        margin-left: 50px;
      }
      &.size-m {
        font: var(--font-m);
      }
      &.size-l {
        font: var(--font-l);
      }
      &:hover {
        color: var(--primary-color);
      }
      &:after {
        content: '';
        display: block;
        position: absolute;
        right: 0;
        bottom: -3px;
        width: 0;
        height: 2px;
        background-color: var(--primary-color);
        transition: width 0.3s;
      }
      &:hover:after {
        content: '';
        width: 100%;
        display: block;
        position: absolute;
        left: 0;
        bottom: -3px;
        height: 2px;
        background-color: var(--primary-color);
        transition: width 0.3s;
      }
    }

    &.btnStyled {
      display: flex;
      justify-content: center;
      align-items: center;
      width: 40%;
      height: 90px;
      border: 5px solid var(--primary-color);
      background: var(--bg-color-primary);
      border-radius: 51px;
      font-weight: 600;
      font: var(--font-l);
      color: var(--color-text);
      text-transform: uppercase;
      text-decoration: none;
      cursor: pointer;
      background-image: linear-gradient(
        45deg,
        rgba(160, 158, 240, 0.7) 50%,
        transparent 50%
      );
      background-position: 100%;
      background-size: 400%;
      transition: background 0.3s ease, filter 0.7s ease;
      &:hover {
        background-position: 0;
        filter: drop-shadow(5px 5px 20px var(--primary-color))
          drop-shadow(-5px -5px 10px #831dd6);
      }
    }
  }
  @media (max-width: 768px) {
    a {
      margin-left: 14px;
      white-space: nowrap;
      &.default.size-l {
        font-size: 16px;
        line-height: 30px;
        font-weight: normal;
        &.responsive {
          font: var(--font-l);
        }
      }
    }
  }

  @media (max-width: 600px) {
    a {
      &.default.size-m {
        font-size: 16px;
        line-height: 24px;
        font-weight: normal;
      }
      &.default.size-l {
        margin-left: 0;
        font-size: 30px;
        line-height: 38px;
        font-weight: normal;
      }
      &.btnStyled.size-l {
        width: 60%;
        margin-left: 0;
        margin-top: 20px;
        font-size: 20px;
        line-height: 28px;
        font-weight: normal;
      }
    }
  }
</style>
