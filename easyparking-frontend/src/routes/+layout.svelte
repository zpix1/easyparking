<script>
    import BackgroundClouds from '$lib/shared/ui/BackgroundClouds.svelte';
    import Footer from '$lib/widgets/Footer.svelte';
    import '../styles/global.css';
    import { getMe } from '$lib/entities/User';
    import { onMount } from 'svelte';

    onMount(() => {
        getMe();
    });
</script>

<div class="app">
    <BackgroundClouds />
    <slot />
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
</style>
