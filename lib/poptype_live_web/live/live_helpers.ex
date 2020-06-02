defmodule PoptypeLiveWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers
   @months %{1 => "Jan", 2 => "Feb", 3 => "Mar", 4 => "Apr",
            5 => "May", 6 => "Jun", 7 => "Jul", 8 => "Aug",
            9 => "Sep", 10 => "Oct", 11 => "Nov", 12 => "Dec"}

   def beautiful(timestamp) do
    '~4..0B, ~ts, ~2..0B'
    |> :io_lib.format([timestamp.year, @months[timestamp.month], timestamp.day])
    |> List.to_string
  end
  @doc """
  Renders a component inside the `PoptypeLiveWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, PoptypeLiveWeb.PostLive.FormComponent,
        id: @post.id || :new,
        action: @live_action,
        post: @post,
        return_to: Routes.post_index_path(@socket, :index) %>
  """
  def live_modal(socket, component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(socket, PoptypeLiveWeb.ModalComponent, modal_opts)
  end


end
