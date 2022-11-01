<script>
    import BackgroundClouds from '$lib/shared/ui/BackgroundClouds.svelte';
    import Footer from '$lib/widgets/Footer.svelte';
    import Navbar from '../lib/widgets/Navbar.svelte';
    import '../styles/global.css';
</script>

<div class="app">
    <BackgroundClouds />
    <Navbar />
    <main>
        <slot />
    </main>
    <Footer />
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
