<script>
    import Link from '$lib/shared/ui/Link.svelte';
    import logo from '../images/logo.svg';
    const links = [
        { page: '/nearby', name: 'nearby parkings' },
        { page: '/starred', name: 'starred' },
        { page: '/login', name: 'log in' },
    ];
</script>

<header>
    <div class="logo">
        <img src={logo} alt="logo" />
        <a href="/">Easy Parking</a>
    </div>
    <ul class="links-list">
        {#each links as link (link.page)}
            <li>
                <Link to={link.page} text={link.name} size="l" />
            </li>
        {/each}
    </ul>
</header>

<style lang="scss">
    header {
        position: fixed;
        min-width: 100%;
        z-index: 999;
        height: var(--navbar-height-desktop);
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 15px 150px;
        text-align: center;
        background: #4d4d6d;
        .logo {
            display: flex;
            justify-content: space-between;
            align-items: center;
            a {
                font-size: 40px;
                line-height: 50px;
                font-weight: 800;
                text-decoration: none;
                color: var(--color-text);
                cursor: pointer;
            }
        }
        .links-list {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0;
            margin: 0;
            list-style: none;
        }
    }

    @media (max-width: 1091px) {
        header {
            padding: 0px 50px;
            .logo {
                a {
                    font-size: 24px;
                    line-height: 30px;
                }
            }
        }
    }
    @media (max-width: 768px) {
        header {
            padding: 0 20px;
            .logo {
                a {
                    font-size: 24px;
                    line-height: 30px;
                }
            }
            .links-list {
                flex: 0 1 55%;
            }
        }
    }
</style>
