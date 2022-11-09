<script>
  import Navbar from '$lib/widgets/Navbar.svelte';
  import '../../styles/global.css';
  const links = [
    { page: '/nearby', name: 'nearby parkings' },
    { page: '/starred', name: 'starred' },
    { page: '/login', name: 'log in' }
  ];
</script>

<div class="app">
  <Navbar {links} />
  <main>
    <slot />
  </main>
</div>

<style>
  .app {
    display: flex;
    flex-direction: column;
    min-height: 100vh;
    max-width: 100%;
    font: var(--font-m);
    font-weight: normal;
    color: var(--color-text);
    background-color: var(--bg-color-primary);
  }
  main {
    min-width: 100%;
    flex: 1;
    display: flex;
    flex-direction: column;
    padding: var(--navbar-height-desktop) 0 0;
    margin: 0 auto;
  }
</style>
