defmodule GenialaisWeb.Live.Datatable do
    use Phoenix.LiveView

    def mount(params, %{"data" => data}, socket) do
        {:ok, assign(socket, :data, data)}
    end
end