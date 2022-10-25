<script>
    import Footer from '$lib/widgets/Footer.svelte';
    import Navbar from '../lib/widgets/Navbar.svelte';
    import '../styles/global.css';
</script>

<div class="app">
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
        width: 100%;
        font: var(--font-m);
        font-weight: normal;
        color: var(--color-text);
        background-color: var(--bg-color-primary);
    }
    main {
        flex: 1;
        display: flex;
        flex-direction: column;
        padding: var(--navbar-height-desktop) 150px;
        margin: 0 auto;
    }

    @media (min-width: 480px) {
        footer {
            padding: 12px 0;
        }
    }
</style>
