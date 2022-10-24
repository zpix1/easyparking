<script>
    import Footer from '$lib/widgets/Footer.svelte';
    import Header from '../lib/widgets/Header.svelte';
    import '../styles/global.css';
</script>

<div class="app">
    <Header />
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
        width: 100%;
        margin: 0 auto;
    }

    /*     footer {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        padding: 12px;
    }

    footer a {
        font-weight: bold;
    }

    @media (min-width: 480px) {
        footer {
            padding: 12px 0;
        }
    } */
</style>
