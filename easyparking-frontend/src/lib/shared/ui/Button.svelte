<script>
</script>

<button>
    <slot />
</button>

<style lang="scss">
    button {
        display: block;
        width: 40%;
        height: 90px;
        border: 5px solid #a09ef0;
        background: #2b2a53;
        border-radius: 51px;
        font-weight: 600;
        font: var(--font-l);
        color: var(--color-text);
        text-align: center;
        text-transform: uppercase;
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
            filter: drop-shadow(5px 5px 20px #a09ef0)
                drop-shadow(-5px -5px 10px #831dd6);
        }
    }
    @media (max-width: 1091px) {
        button {
            max-width: 40%;
        }
    }
</style>
