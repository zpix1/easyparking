<script>
    import Link from '$lib/shared/ui/Link.svelte';
</script>

<footer>
    <p class="rights">© 2022 Easyparking, inc</p>
    <div class="links">
        <Link to="https://github.com/zpix1/easyparking" text="docs" external />
        <Link
            to="https://github.com/zpix1/easyparking"
            text="source code"
            external
        />
    </div>
</footer>

<style lang="scss">
    footer {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 22px 158px;
        background: rgba(29, 27, 58, 0.7);
    }
</style>
