<script>
  import Link from '$lib/shared/ui/Link.svelte';
</script>

<footer>
  <p class="rights">© 2022 Easyparking, inc</p>
  <div class="links">
    <Link
      to="https://github.com/zpix1/easyparking"
      text="docs"
      classNames={'default shifted'}
      external
    />
    <Link
      to="https://github.com/zpix1/easyparking"
      text="source code"
      classNames={'default shifted'}
      external
    />
  </div>
</footer>

<style lang="scss">
  footer {
    min-width: 100%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 22px 158px;
    background: rgb(29, 27, 58);
  }
  @media (max-width: 768px) {
    footer {
      padding: 30px 20px;
    }
  }
</style>
