<script lang="ts">
    import Button from '$lib/shared/ui/Button.svelte';
    import Modal from "$lib/shared/ui/Modal.svelte";
    import IconButton from "$lib/shared/ui/IconButton.svelte";
    import AdminConsoleParkingCreationForm from "$lib/widgets/AdminConsoleParkingCreationForm.svelte";
    import ConfirmationModal from "../../../../lib/widgets/ConfirmationModal.svelte";

    interface TableRowData {
        name: string;
        address: string;
        coordinates: string;
        creationTime: string;
        endpoint: string;
        lastUpdate: string;
    }

    let tableData: TableRowData[] = [
        {
            name: "NAMEUNIQUE1",
            address: "ADDRESS",
            coordinates: "COORDINATES",
            creationTime: "CREATED",
            endpoint: "CAMERA",
            lastUpdate: "LAST UPDATE",
        },
        {
            name: "NAMEUNIQUE2",
            address: "ADDRESS",
            coordinates: "COORDINATES",
            creationTime: "CREATED",
            endpoint: "CAMERA ENDPOINT",
            lastUpdate: "UPDATE",
        },
    ];
    let formModalOpen: boolean = false;
    let deletionConfirmModalOpen: boolean = false;

    const onAddParking = () => {
        formModalOpen = true;
    }
    const onEditParking = (index) => {
        formModalOpen = true;
    }
    const onDeleteParking = (index) => {
        deletionConfirmModalOpen = true;
    }
    const onCloseForm = () => {
        formModalOpen = false;
    }
    const onConfirmDeletion = () => {
        deletionConfirmModalOpen = false;
    }
    const onCancelDeletion = () => {
        deletionConfirmModalOpen = false;
    }
</script>

<svelte:head>
    <title>EasyParking</title>
    <meta name="description" content="EasyParking about" />
</svelte:head>

<section class="console">
    <div class="content-wrapper">
        <Modal open={formModalOpen} onCloseCallback={onCloseForm}>
            <AdminConsoleParkingCreationForm />
        </Modal>
        <ConfirmationModal
                open={deletionConfirmModalOpen}
                onClose={onCancelDeletion}
                onConfirm={() => {}}
        />
        <div class="head-wrapper">
            <h1 class="console-head">PARKINGS</h1>
            <div class="btn-wrapper">
                <Button onClick={onAddParking}>Add New</Button>
            </div>
        </div>
        <table class="console-table">
            <thead>
                <td>NAME</td>
                <td>ADDRESS</td>
                <td>COORDINATES</td>
                <td>CREATED</td>
                <td>CAMERA ENDPOINT</td>
                <td>LAST UPDATE</td>
                <td></td>
            </thead>
            {#each tableData as {name, address, coordinates, creationTime, endpoint, lastUpdate}, i (name)}
                <tr>
                    <td>{name}</td>
                    <td>{address}</td>
                    <td>{coordinates}</td>
                    <td>{creationTime}</td>
                    <td>{endpoint}</td>
                    <td>{lastUpdate}</td>
                    <td class="console-tools">
                        <IconButton onClick={() => onEditParking(i)} icon="pencil" />
                        <IconButton onClick={() => onDeleteParking(i)} icon="trash" />
                    </td>
                </tr>
            {/each}
            <tr>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
        </table>
    </div>
</section>

<style lang="scss">
  .console {
    font: var(--font-m);
    font-family: var(--font-family-secondary);
    display: flex;
    flex-flow: column nowrap;
    flex: 1;
  }

  .content-wrapper {
    margin: 1.5rem;
    display: flex;
    flex-flow: column nowrap;
    flex: 1;
    row-gap: 1rem;

    h1 {
      font: var(--font-l);
      font-weight: normal;
    }
  }

  .head-wrapper {
    display: flex;
    flex-flow: row nowrap;
    flex: 0 1 1%;
    padding-left: 1rem;
    padding-right: 1rem;
    justify-content: space-between;
  }

  .console-head {
    align-self: end;
  }

  .btn-wrapper {
    flex-basis: 15%;
    display: flex;
    flex-flow: row nowrap;
    justify-content: flex-end;
  }

  .console-table {
    font: var(--font-m);
    display: table;
    flex: 1 1 90%;
    border: rgba(107, 107, 133) 1px solid;
    border-radius: 10px 10px 10px 10px;
    background: rgba(107, 107, 133, 0.5);
    border-spacing: 0;

    thead {
      td{
        border-bottom: rgba(192, 189, 206, 0.5) 1px solid;
      }
    }

    tr, thead {
      display: table-row;
      td {
        display: table-cell;
        border-right: rgb(192, 189, 206, 0.5) 1px solid;
        padding: 10px;
      }

      td.console-tools {
          display: flex;
          flex-flow: row nowrap;
          column-gap: .5rem;
      }

      td:last-child {
        border-right: none;
      }
    }

    tr:last-child {
      display: table-row;
      height: 100%;
    }

  }
</style>
