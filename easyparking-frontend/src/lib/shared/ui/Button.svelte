<script>
    export let type = '';
    export let size = 'm';
</script>

<button {type} class:size_m={size === 'm'}>
    <slot />
</button>

<style lang="scss">
    button {
        display: block;
        margin: 50px auto 0;
        border: 5px solid #a09ef0;
        background: #2b2a53;
        border-radius: 51px;
        font-weight: 600;
        color: var(--color-text);
        text-align: center;
        text-transform: uppercase;
        background-image: linear-gradient(
            45deg,
            rgba(160, 158, 240, 0.7) 50%,
            transparent 50%
        );
        background-position: 100%;
        background-size: 400%;
        transition: background 0.3s ease, filter 0.7s ease;
        cursor: pointer;
        &.size_m {
            min-width: 60%;
            height: 60px;
            font: var(--font-m);
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
        button {
            &.size_m {
                min-width: 80%;
                height: 60px;
                font: var(--font-m);
            }
        }
    }
</style>
